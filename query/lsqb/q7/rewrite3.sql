create or replace view aggView2428330574046372178 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin2743409145973235697 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView2428330574046372178 where Message_hasTag_Tag.MessageId=aggView2428330574046372178.v1;
create or replace view aggView8373134540341909808 as select v1, SUM(annot) as annot from aggJoin2743409145973235697 group by v1;
create or replace view aggJoin3501573274624205876 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView8373134540341909808 where Message_hasCreator_Person.MessageId=aggView8373134540341909808.v1;
create or replace view aggView6154276052023184423 as select v1, SUM(annot) as annot from aggJoin3501573274624205876 group by v1;
create or replace view aggJoin3584647265766350557 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6154276052023184423 where Comment_replyOf_Message.ParentMessageId=aggView6154276052023184423.v1;
select SUM(annot) as v9 from aggJoin3584647265766350557;
