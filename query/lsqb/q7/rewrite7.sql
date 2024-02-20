## AggReduce Phase: 

# AggReduce21
# 1. aggView
create or replace view aggView7904387366314842370 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin8559943108142259777 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7904387366314842370 where Message_hasTag_Tag.MessageId=aggView7904387366314842370.v1;

# AggReduce22
# 1. aggView
create or replace view aggView6765036510273147052 as select v1, SUM(annot) as annot from aggJoin8559943108142259777 group by v1;
# 2. aggJoin
create or replace view aggJoin685448896397801883 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6765036510273147052 where Comment_replyOf_Message.ParentMessageId=aggView6765036510273147052.v1;

# AggReduce23
# 1. aggView
create or replace view aggView3643410143982220317 as select v1, SUM(annot) as annot from aggJoin685448896397801883 group by v1;
# 2. aggJoin
create or replace view aggJoin2690035080907238037 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3643410143982220317 where Message_hasCreator_Person.MessageId=aggView3643410143982220317.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin2690035080907238037;

# drop view aggView7904387366314842370, aggJoin8559943108142259777, aggView6765036510273147052, aggJoin685448896397801883, aggView3643410143982220317, aggJoin2690035080907238037;
