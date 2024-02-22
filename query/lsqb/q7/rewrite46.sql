create or replace view aggView7834824291546498849 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin2042209548801654517 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView7834824291546498849 where Message_hasCreator_Person.MessageId=aggView7834824291546498849.v1;
create or replace view aggView8582726307904495116 as select v1, SUM(annot) as annot from aggJoin2042209548801654517 group by v1;
create or replace view aggJoin4292790625580168194 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8582726307904495116 where Message_hasTag_Tag.MessageId=aggView8582726307904495116.v1;
create or replace view aggView6216677262850131416 as select v1, SUM(annot) as annot from aggJoin4292790625580168194 group by v1;
create or replace view aggJoin2335367374674099969 as select annot from Person_likes_Message as Person_likes_Message, aggView6216677262850131416 where Person_likes_Message.MessageId=aggView6216677262850131416.v1;
select SUM(annot) as v9 from aggJoin2335367374674099969;
