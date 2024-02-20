## AggReduce Phase: 

# AggReduce24
# 1. aggView
create or replace view aggView2634864190842332730 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin2960112483487202052 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2634864190842332730 where Comment_replyOf_Message.ParentMessageId=aggView2634864190842332730.v1;

# AggReduce25
# 1. aggView
create or replace view aggView6398316468633087273 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin1792098627437437771 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6398316468633087273 where Message_hasCreator_Person.MessageId=aggView6398316468633087273.v1;

# AggReduce26
# 1. aggView
create or replace view aggView2582417912749507956 as select v1, SUM(annot) as annot from aggJoin1792098627437437771 group by v1;
# 2. aggJoin
create or replace view aggJoin5312248975039515763 as select aggJoin2960112483487202052.annot * aggView2582417912749507956.annot as annot from aggJoin2960112483487202052 join aggView2582417912749507956 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin5312248975039515763;

# drop view aggView2634864190842332730, aggJoin2960112483487202052, aggView6398316468633087273, aggJoin1792098627437437771, aggView2582417912749507956, aggJoin5312248975039515763;
