## AggReduce Phase: 

# AggReduce87
# 1. aggView
create or replace view aggView6120812206337974266 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin13325222891793918 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView6120812206337974266 where Person_likes_Message.MessageId=aggView6120812206337974266.v1;

# AggReduce88
# 1. aggView
create or replace view aggView9217186087947852871 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin5781379629395438480 as select v1, aggJoin13325222891793918.annot * aggView9217186087947852871.annot as annot from aggJoin13325222891793918 join aggView9217186087947852871 using(v1);

# AggReduce89
# 1. aggView
create or replace view aggView6476875372260261037 as select v1, SUM(annot) as annot from aggJoin5781379629395438480 group by v1;
# 2. aggJoin
create or replace view aggJoin7488621100178947797 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6476875372260261037 where Message_hasTag_Tag.MessageId=aggView6476875372260261037.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin7488621100178947797;

# drop view aggView6120812206337974266, aggJoin13325222891793918, aggView9217186087947852871, aggJoin5781379629395438480, aggView6476875372260261037, aggJoin7488621100178947797;
