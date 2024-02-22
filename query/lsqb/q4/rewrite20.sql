create or replace view aggView4711631553573562602 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin8545813127608342341 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4711631553573562602 where Comment_replyOf_Message.ParentMessageId=aggView4711631553573562602.v1;
create or replace view aggView2712038879815098342 as select v1, SUM(annot) as annot from aggJoin8545813127608342341 group by v1;
create or replace view aggJoin4271584704103424953 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView2712038879815098342 where Person_likes_Message.MessageId=aggView2712038879815098342.v1;
create or replace view aggView2010092949263949658 as select v1, SUM(annot) as annot from aggJoin4271584704103424953 group by v1;
create or replace view aggJoin7998909464427445422 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView2010092949263949658 where Message_hasCreator_Person.MessageId=aggView2010092949263949658.v1;
select SUM(annot) as v9 from aggJoin7998909464427445422;
