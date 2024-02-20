## AggReduce Phase: 

# AggReduce15
# 1. aggView
create or replace view aggView3744977125536392414 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin1240594564174696751 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView3744977125536392414 where Person_likes_Message.MessageId=aggView3744977125536392414.v1;

# AggReduce16
# 1. aggView
create or replace view aggView4295388857378965372 as select v1, SUM(annot) as annot from aggJoin1240594564174696751 group by v1;
# 2. aggJoin
create or replace view aggJoin4152122440365786210 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4295388857378965372 where Comment_replyOf_Message.ParentMessageId=aggView4295388857378965372.v1;

# AggReduce17
# 1. aggView
create or replace view aggView3950356305675902261 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin5971695870897723725 as select aggJoin4152122440365786210.annot * aggView3950356305675902261.annot as annot from aggJoin4152122440365786210 join aggView3950356305675902261 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin5971695870897723725;

# drop view aggView3744977125536392414, aggJoin1240594564174696751, aggView4295388857378965372, aggJoin4152122440365786210, aggView3950356305675902261, aggJoin5971695870897723725;
