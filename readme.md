# AWS SNS Notification Service

This project demonstrates how to set up and use Amazon Simple Notification Service (SNS) with a Spring Boot application. The service allows sending notifications through AWS SNS.

## Prerequisites

- Java 17 or higher
- Docker and Docker Compose
- AWS Account
- Maven (optional if using Docker)

## AWS SNS Setup

1. **Create an SNS Topic**
   ```bash
   # Using AWS CLI
   aws sns create-topic --name notification-topic
   ```
   Or through AWS Console:
   1. Go to Amazon SNS Console
   2. Click "Create topic"
   3. Select "Standard" type
   4. Name it "notification-topic"
   5. Keep default settings and click "Create topic"
   6. Copy the Topic ARN for later use

2. **Create IAM User**
   1. Go to IAM Console
   2. Create new IAM user with programmatic access
   3. Attach policy with these permissions:
      ```json
      {
          "Version": "2012-10-17",
          "Statement": [
              {
                  "Effect": "Allow",
                  "Action": [
                      "sns:Publish"
                  ],
                  "Resource": "arn:aws:sns:*:*:notification-topic"
              }
          ]
      }
      ```
   4. Save the Access Key ID and Secret Access Key

## Configuration

1. **Environment Variables**
   Create a `.env` file in the root directory:
   ```
   AWS_ACCESS_KEY_ID=your_access_key_id
   AWS_SECRET_ACCESS_KEY=your_secret_access_key
   AWS_REGION=your_region
   AWS_SNS_TOPIC_ARN=your_topic_arn
   ```

2. **Application Properties**
   The application will automatically read these values from the environment variables.

## Building and Running

### Using Docker

1. Build and run using Docker Compose:
   ```bash
   docker-compose up --build
   ```

### Using Maven Locally

1. Build the project:
   ```bash
   ./mvnw clean package
   ```

2. Run the application:
   ```bash
   ./mvnw spring-boot:run
   ```

## Testing the Service

You can test the notification service using curl or any API client:
