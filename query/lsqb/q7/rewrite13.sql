## AggReduce Phase: 

# AggReduce39
# 1. aggView
create or replace view aggView495708625606203643 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin2234415796523099263 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView495708625606203643 where Comment_replyOf_Message.ParentMessageId=aggView495708625606203643.v1;

# AggReduce40
# 1. aggView
create or replace view aggView8360344901783958261 as select v1, SUM(annot) as annot from aggJoin2234415796523099263 group by v1;
# 2. aggJoin
create or replace view aggJoin5446391808752442259 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView8360344901783958261 where Message_hasCreator_Person.MessageId=aggView8360344901783958261.v1;

# AggReduce41
# 1. aggView
create or replace view aggView20653246535899517 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin8575516051618185550 as select aggJoin5446391808752442259.annot * aggView20653246535899517.annot as annot from aggJoin5446391808752442259 join aggView20653246535899517 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin8575516051618185550;

# drop view aggView495708625606203643, aggJoin2234415796523099263, aggView8360344901783958261, aggJoin5446391808752442259, aggView20653246535899517, aggJoin8575516051618185550;
