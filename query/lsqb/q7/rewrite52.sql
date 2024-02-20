## AggReduce Phase: 

# AggReduce156
# 1. aggView
create or replace view aggView6028020482611789355 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin5191431894519292748 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView6028020482611789355 where Person_likes_Message.MessageId=aggView6028020482611789355.v1;

# AggReduce157
# 1. aggView
create or replace view aggView3965667180768458315 as select v1, SUM(annot) as annot from aggJoin5191431894519292748 group by v1;
# 2. aggJoin
create or replace view aggJoin7513103092749529190 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3965667180768458315 where Message_hasCreator_Person.MessageId=aggView3965667180768458315.v1;

# AggReduce158
# 1. aggView
create or replace view aggView4443471769605728349 as select v1, SUM(annot) as annot from aggJoin7513103092749529190 group by v1;
# 2. aggJoin
create or replace view aggJoin1994825805073832581 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4443471769605728349 where Message_hasTag_Tag.MessageId=aggView4443471769605728349.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin1994825805073832581;

# drop view aggView6028020482611789355, aggJoin5191431894519292748, aggView3965667180768458315, aggJoin7513103092749529190, aggView4443471769605728349, aggJoin1994825805073832581;
