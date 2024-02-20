## AggReduce Phase: 

# AggReduce153
# 1. aggView
create or replace view aggView5719125434768039439 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin6511847757120581877 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView5719125434768039439 where Message_hasTag_Tag.MessageId=aggView5719125434768039439.v1;

# AggReduce154
# 1. aggView
create or replace view aggView6417369750281034494 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin6692743516328921102 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6417369750281034494 where Comment_replyOf_Message.ParentMessageId=aggView6417369750281034494.v1;

# AggReduce155
# 1. aggView
create or replace view aggView2691087184239500491 as select v1, SUM(annot) as annot from aggJoin6692743516328921102 group by v1;
# 2. aggJoin
create or replace view aggJoin7283231012287789414 as select aggJoin6511847757120581877.annot * aggView2691087184239500491.annot as annot from aggJoin6511847757120581877 join aggView2691087184239500491 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin7283231012287789414;

# drop view aggView5719125434768039439, aggJoin6511847757120581877, aggView6417369750281034494, aggJoin6692743516328921102, aggView2691087184239500491, aggJoin7283231012287789414;
