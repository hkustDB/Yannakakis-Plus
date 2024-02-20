## AggReduce Phase: 

# AggReduce90
# 1. aggView
create or replace view aggView4557341044482505231 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin8689485396849168146 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView4557341044482505231 where Person_likes_Message.MessageId=aggView4557341044482505231.v1;

# AggReduce91
# 1. aggView
create or replace view aggView4240024186836977409 as select v1, SUM(annot) as annot from aggJoin8689485396849168146 group by v1;
# 2. aggJoin
create or replace view aggJoin5134776689101084820 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4240024186836977409 where Message_hasTag_Tag.MessageId=aggView4240024186836977409.v1;

# AggReduce92
# 1. aggView
create or replace view aggView2449667319973821793 as select v1, SUM(annot) as annot from aggJoin5134776689101084820 group by v1;
# 2. aggJoin
create or replace view aggJoin2254712131713143381 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView2449667319973821793 where Message_hasCreator_Person.MessageId=aggView2449667319973821793.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin2254712131713143381;

# drop view aggView4557341044482505231, aggJoin8689485396849168146, aggView4240024186836977409, aggJoin5134776689101084820, aggView2449667319973821793, aggJoin2254712131713143381;
