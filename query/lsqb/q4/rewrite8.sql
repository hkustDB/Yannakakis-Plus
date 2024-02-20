## AggReduce Phase: 

# AggReduce24
# 1. aggView
create or replace view aggView4859027859919514940 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin2322368371465618649 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView4859027859919514940 where Person_likes_Message.MessageId=aggView4859027859919514940.v1;

# AggReduce25
# 1. aggView
create or replace view aggView795354934594038882 as select v1, SUM(annot) as annot from aggJoin2322368371465618649 group by v1;
# 2. aggJoin
create or replace view aggJoin7854068565674254869 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView795354934594038882 where Message_hasTag_Tag.MessageId=aggView795354934594038882.v1;

# AggReduce26
# 1. aggView
create or replace view aggView5437041510809569658 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin2989488813908789529 as select aggJoin7854068565674254869.annot * aggView5437041510809569658.annot as annot from aggJoin7854068565674254869 join aggView5437041510809569658 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin2989488813908789529;

# drop view aggView4859027859919514940, aggJoin2322368371465618649, aggView795354934594038882, aggJoin7854068565674254869, aggView5437041510809569658, aggJoin2989488813908789529;
