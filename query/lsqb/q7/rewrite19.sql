## AggReduce Phase: 

# AggReduce57
# 1. aggView
create or replace view aggView3877233170860472355 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin5614916684201943625 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView3877233170860472355 where Message_hasTag_Tag.MessageId=aggView3877233170860472355.v1;

# AggReduce58
# 1. aggView
create or replace view aggView8879455850780334104 as select v1, SUM(annot) as annot from aggJoin5614916684201943625 group by v1;
# 2. aggJoin
create or replace view aggJoin1976440364819617361 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView8879455850780334104 where Message_hasCreator_Person.MessageId=aggView8879455850780334104.v1;

# AggReduce59
# 1. aggView
create or replace view aggView5359002065886085474 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin4976412756389777372 as select aggJoin1976440364819617361.annot * aggView5359002065886085474.annot as annot from aggJoin1976440364819617361 join aggView5359002065886085474 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin4976412756389777372;

# drop view aggView3877233170860472355, aggJoin5614916684201943625, aggView8879455850780334104, aggJoin1976440364819617361, aggView5359002065886085474, aggJoin4976412756389777372;
