create or replace view aggView6124547318085052352 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin9200321111978143424 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6124547318085052352 where Message_hasCreator_Person.MessageId=aggView6124547318085052352.v1;
create or replace view aggView6278499765219664678 as select v1, SUM(annot) as annot from aggJoin9200321111978143424 group by v1;
create or replace view aggJoin1707070598328247557 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6278499765219664678 where Comment_replyOf_Message.ParentMessageId=aggView6278499765219664678.v1;
create or replace view aggView8323036403570938715 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin8449445528593921581 as select aggJoin1707070598328247557.annot * aggView8323036403570938715.annot as annot from aggJoin1707070598328247557 join aggView8323036403570938715 using(v1);
select SUM(annot) as v9 from aggJoin8449445528593921581;
