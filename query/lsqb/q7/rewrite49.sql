## AggReduce Phase: 

# AggReduce147
# 1. aggView
create or replace view aggView1757853737761679288 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin3614851019759597374 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView1757853737761679288 where Message_hasTag_Tag.MessageId=aggView1757853737761679288.v1;

# AggReduce148
# 1. aggView
create or replace view aggView1467599655927274690 as select v1, SUM(annot) as annot from aggJoin3614851019759597374 group by v1;
# 2. aggJoin
create or replace view aggJoin4998609839760890657 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1467599655927274690 where Message_hasCreator_Person.MessageId=aggView1467599655927274690.v1;

# AggReduce149
# 1. aggView
create or replace view aggView9041474883748369094 as select v1, SUM(annot) as annot from aggJoin4998609839760890657 group by v1;
# 2. aggJoin
create or replace view aggJoin4315553794918247688 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView9041474883748369094 where Comment_replyOf_Message.ParentMessageId=aggView9041474883748369094.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin4315553794918247688;

# drop view aggView1757853737761679288, aggJoin3614851019759597374, aggView1467599655927274690, aggJoin4998609839760890657, aggView9041474883748369094, aggJoin4315553794918247688;
