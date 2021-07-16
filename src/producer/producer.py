import os
import random
import json
import asyncio
from aiokafka.producer import AIOKafkaProducer
from generator import create_single_payload
from transformer import transform_temperature

#Configuration
topic =  os.environ.get('SENSOR_TOPIC')
kafka_broker_url = os.environ.get('KAFKA_BROKER_URL')

def serializer(data):
    """
    function to serialize dict to json
    """
    return json.dumps(data).encode()

async def produce_payload(num, loop):
    """
    function to transform payload and batch append to kafka producer
    """
    producer = AIOKafkaProducer(
        bootstrap_servers=kafka_broker_url,
        loop=loop,
    )
    await producer.start()

    batch = producer.create_batch()

    i = 0
    while i < num:
        payload: dict = create_single_payload()
        transformed: dict = transform_temperature(payload)
        serialized = serializer(transformed)
        metadata = batch.append(key=None, value=serialized, timestamp=None)
        if metadata is None:
            partitions = await producer.partitions_for(topic)
            partition = random.choice(tuple(partitions))
            await producer.send_batch(batch, topic, partition=partition)
            print("%d messages sent to partition %d"
                  % (batch.record_count(), partition))
            batch = producer.create_batch()
            continue
        i += 1
    partitions = await producer.partitions_for(topic)
    partition = random.choice(tuple(partitions))
    await producer.send_batch(batch, topic, partition=partition)
    print("%d messages sent to partition %d"
          % (batch.record_count(), partition))
    await producer.stop()

if __name__ == '__main__':
    loop = asyncio.get_event_loop()
    loop.run_until_complete(produce_payload(100000, loop))
    loop.close()
