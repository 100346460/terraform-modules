from google.cloud import pubsub_v1
import subprocess

result = subprocess.run(["terraform", "test", "-filter=tests/test_integrate_bucket_pubsub.tftest.hcl"], capture_output=True, text=True)
print("Output:", result.stdout)


# Set up Pub/Sub subscriber client
subscriber = pubsub_v1.SubscriberClient()

response = subscriber.pull(request={"subscription": "storage-subscription", "max_messages": 10})

# Process the pulled messages
for received_message in response.received_messages:
    message = received_message.message
    print(f"Received message: {message.data}")
    # Acknowledge the message to mark it as processed
    subscriber.acknowledge(request={"subscription": subscription_path, "ack_ids": [received_message.ack_id]})