create or replace view aggView9065067590192155986 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin5149056322926088708 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView9065067590192155986 where Message_hasCreator_Person.MessageId=aggView9065067590192155986.v1;
create or replace view aggView6329650044650107120 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin1003081467618458522 as select v1, aggJoin5149056322926088708.annot * aggView6329650044650107120.annot as annot from aggJoin5149056322926088708 join aggView6329650044650107120 using(v1);
create or replace view aggView207866679300575907 as select v1, SUM(annot) as annot from aggJoin1003081467618458522 group by v1;
create or replace view aggJoin1703107239420637123 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView207866679300575907 where Message_hasTag_Tag.MessageId=aggView207866679300575907.v1;
select SUM(annot) as v9 from aggJoin1703107239420637123;
