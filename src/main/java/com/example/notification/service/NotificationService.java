package com.example.notification.service;

import com.example.notification.dto.NotificationRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import software.amazon.awssdk.services.sns.SnsClient;
import software.amazon.awssdk.services.sns.model.PublishRequest;

@Service
@RequiredArgsConstructor
public class NotificationService {

    private final SnsClient snsClient;

    @Value("${aws.sns.topic.arn}")
    private String topicArn;

    public void publishMessage(NotificationRequest request) {
        PublishRequest publishRequest = PublishRequest.builder()
                .topicArn(topicArn)
                .subject(request.getSubject())
                .message(request.getMessage())
                .build();

        snsClient.publish(publishRequest);
    }
} 