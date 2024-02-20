## AggReduce Phase: 

# AggReduce3
# 1. aggView
create or replace view aggView4153928958062935070 as select CommentId as v3, COUNT(*) as annot, TagId as v8 from Comment_hasTag_Tag as cht2 group by CommentId,TagId;
# 2. aggJoin
create or replace view aggJoin4091275403664456335 as select ParentMessageId as v1, v8, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4153928958062935070 where Comment_replyOf_Message.CommentId=aggView4153928958062935070.v3;

# AggReduce4
# 1. aggView
create or replace view aggView6868157454512752563 as select v1, SUM(annot) as annot, v8 from aggJoin4091275403664456335 group by v1,v8;
# 2. aggJoin
create or replace view aggJoin3437861376319331014 as select TagId as v2, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6868157454512752563 where Message_hasTag_Tag.MessageId=aggView6868157454512752563.v1 and TagId<v8;

# AggReduce5
# 1. aggView
create or replace view aggView2007367588324856443 as select v2, SUM(annot) as annot from aggJoin3437861376319331014 group by v2;
# 2. aggJoin
create or replace view aggJoin9106495250401991139 as select annot from Comment_hasTag_Tag as cht1, aggView2007367588324856443 where cht1.TagId=aggView2007367588324856443.v2;
# Final result: 
select SUM(annot) as v9 from aggJoin9106495250401991139;

# drop view aggView4153928958062935070, aggJoin4091275403664456335, aggView6868157454512752563, aggJoin3437861376319331014, aggView2007367588324856443, aggJoin9106495250401991139;
