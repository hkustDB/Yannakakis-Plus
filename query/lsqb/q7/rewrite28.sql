## AggReduce Phase: 

# AggReduce84
# 1. aggView
create or replace view aggView8936556403516797 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin2252175249998182969 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8936556403516797 where Message_hasTag_Tag.MessageId=aggView8936556403516797.v1;

# AggReduce85
# 1. aggView
create or replace view aggView574506902578694384 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin5010473836224744472 as select v1, aggJoin2252175249998182969.annot * aggView574506902578694384.annot as annot from aggJoin2252175249998182969 join aggView574506902578694384 using(v1);

# AggReduce86
# 1. aggView
create or replace view aggView6941516220401514247 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin8783152375474890324 as select aggJoin5010473836224744472.annot * aggView6941516220401514247.annot as annot from aggJoin5010473836224744472 join aggView6941516220401514247 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin8783152375474890324;

# drop view aggView8936556403516797, aggJoin2252175249998182969, aggView574506902578694384, aggJoin5010473836224744472, aggView6941516220401514247, aggJoin8783152375474890324;
