## AggReduce Phase: 

# AggReduce123
# 1. aggView
create or replace view aggView6130731410718134418 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin2916798386983593060 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6130731410718134418 where Message_hasCreator_Person.MessageId=aggView6130731410718134418.v1;

# AggReduce124
# 1. aggView
create or replace view aggView8303275038707516034 as select v1, SUM(annot) as annot from aggJoin2916798386983593060 group by v1;
# 2. aggJoin
create or replace view aggJoin8206834387228955259 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8303275038707516034 where Comment_replyOf_Message.ParentMessageId=aggView8303275038707516034.v1;

# AggReduce125
# 1. aggView
create or replace view aggView9044780469601262445 as select v1, SUM(annot) as annot from aggJoin8206834387228955259 group by v1;
# 2. aggJoin
create or replace view aggJoin6869598057709794202 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView9044780469601262445 where Message_hasTag_Tag.MessageId=aggView9044780469601262445.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin6869598057709794202;

# drop view aggView6130731410718134418, aggJoin2916798386983593060, aggView8303275038707516034, aggJoin8206834387228955259, aggView9044780469601262445, aggJoin6869598057709794202;
