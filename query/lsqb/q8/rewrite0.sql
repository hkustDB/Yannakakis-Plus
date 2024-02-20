## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView6058606356883535611 as select TagId as v2, COUNT(*) as annot from Comment_hasTag_Tag as cht1 group by TagId;
# 2. aggJoin
create or replace view aggJoin7623688700224339861 as select MessageId as v1, TagId as v2, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6058606356883535611 where Message_hasTag_Tag.TagId=aggView6058606356883535611.v2;

# AggReduce1
# 1. aggView
create or replace view aggView8284409786446162178 as select v1, SUM(annot) as annot, v2 from aggJoin7623688700224339861 group by v1,v2;
# 2. aggJoin
create or replace view aggJoin2882911302248044557 as select CommentId as v3, v2, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8284409786446162178 where Comment_replyOf_Message.ParentMessageId=aggView8284409786446162178.v1;

# AggReduce2
# 1. aggView
create or replace view aggView1399013881218897108 as select v3, SUM(annot) as annot, v2 from aggJoin2882911302248044557 group by v3,v2;
# 2. aggJoin
create or replace view aggJoin4339794744346610192 as select annot from Comment_hasTag_Tag as cht2, aggView1399013881218897108 where cht2.CommentId=aggView1399013881218897108.v3 and v2<TagId;
# Final result: 
select SUM(annot) as v9 from aggJoin4339794744346610192;

# drop view aggView6058606356883535611, aggJoin7623688700224339861, aggView8284409786446162178, aggJoin2882911302248044557, aggView1399013881218897108, aggJoin4339794744346610192;
