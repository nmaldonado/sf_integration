trigger AccountTrigger on Account (before insert, before update, after insert, after update) {
   AccountTriggerHandler.run(Trigger.isBefore, Trigger.isAfter, Trigger.operationType);
}