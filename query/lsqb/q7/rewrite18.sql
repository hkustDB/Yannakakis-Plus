## AggReduce Phase: 

# AggReduce54
# 1. aggView
create or replace view aggView928497157745445001 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin5141984551173536688 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView928497157745445001 where Person_likes_Message.MessageId=aggView928497157745445001.v1;

# AggReduce55
# 1. aggView
create or replace view aggView57592151188143100 as select v1, SUM(annot) as annot from aggJoin5141984551173536688 group by v1;
# 2. aggJoin
create or replace view aggJoin3578409706492207201 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView57592151188143100 where Message_hasCreator_Person.MessageId=aggView57592151188143100.v1;

# AggReduce56
# 1. aggView
create or replace view aggView2613374260454326846 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin6239404434993123260 as select aggJoin3578409706492207201.annot * aggView2613374260454326846.annot as annot from aggJoin3578409706492207201 join aggView2613374260454326846 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin6239404434993123260;

# drop view aggView928497157745445001, aggJoin5141984551173536688, aggView57592151188143100, aggJoin3578409706492207201, aggView2613374260454326846, aggJoin6239404434993123260;
