// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SmsModelImpl _$$SmsModelImplFromJson(Map<String, dynamic> json) =>
    _$SmsModelImpl(
      id: json['id'] as String,
      address: json['address'] as String,
      body: json['body'] as String,
      date: (json['date'] as num).toInt(),
      isRead: json['isRead'] as bool? ?? false,
    );

Map<String, dynamic> _$$SmsModelImplToJson(_$SmsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'body': instance.body,
      'date': instance.date,
      'isRead': instance.isRead,
    };

_$SmsConversationModelImpl _$$SmsConversationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SmsConversationModelImpl(
      address: json['address'] as String,
      lastMessage: json['lastMessage'] as String,
      messageCount: (json['messageCount'] as num).toInt(),
      lastMessageDate: (json['lastMessageDate'] as num).toInt(),
    );

Map<String, dynamic> _$$SmsConversationModelImplToJson(
        _$SmsConversationModelImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'lastMessage': instance.lastMessage,
      'messageCount': instance.messageCount,
      'lastMessageDate': instance.lastMessageDate,
    };
