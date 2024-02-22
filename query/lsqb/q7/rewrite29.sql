create or replace view aggView4323802941932202565 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin144610152301267368 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView4323802941932202565 where Person_likes_Message.MessageId=aggView4323802941932202565.v1;
create or replace view aggView3329265534948536505 as select v1, SUM(annot) as annot from aggJoin144610152301267368 group by v1;
create or replace view aggJoin1329747969886031426 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView3329265534948536505 where Comment_replyOf_Message.ParentMessageId=aggView3329265534948536505.v1;
create or replace view aggView6783235965158239285 as select v1, SUM(annot) as annot from aggJoin1329747969886031426 group by v1;
create or replace view aggJoin2784172813506433593 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6783235965158239285 where Message_hasCreator_Person.MessageId=aggView6783235965158239285.v1;
select SUM(annot) as v9 from aggJoin2784172813506433593;
