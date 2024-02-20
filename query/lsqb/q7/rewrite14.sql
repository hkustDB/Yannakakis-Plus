## AggReduce Phase: 

# AggReduce42
# 1. aggView
create or replace view aggView5596115166592349306 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin5450670278192328334 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5596115166592349306 where Comment_replyOf_Message.ParentMessageId=aggView5596115166592349306.v1;

# AggReduce43
# 1. aggView
create or replace view aggView2097433604130486992 as select v1, SUM(annot) as annot from aggJoin5450670278192328334 group by v1;
# 2. aggJoin
create or replace view aggJoin106248209166177346 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView2097433604130486992 where Message_hasTag_Tag.MessageId=aggView2097433604130486992.v1;

# AggReduce44
# 1. aggView
create or replace view aggView5648864537164900190 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin4182807511724092239 as select aggJoin106248209166177346.annot * aggView5648864537164900190.annot as annot from aggJoin106248209166177346 join aggView5648864537164900190 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin4182807511724092239;

# drop view aggView5596115166592349306, aggJoin5450670278192328334, aggView2097433604130486992, aggJoin106248209166177346, aggView5648864537164900190, aggJoin4182807511724092239;
