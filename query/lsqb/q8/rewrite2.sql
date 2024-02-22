create or replace view aggView3288229547697571037 as select TagId as v2, COUNT(*) as annot from Comment_hasTag_Tag as cht1 group by TagId;
create or replace view aggJoin2579144380960061737 as select MessageId as v1, TagId as v2, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView3288229547697571037 where Message_hasTag_Tag.TagId=aggView3288229547697571037.v2;
create or replace view aggView4777630678631792815 as select v1, SUM(annot) as annot, v2 from aggJoin2579144380960061737 group by v1,v2;
create or replace view aggJoin4960903443201522322 as select CommentId as v3, v2, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4777630678631792815 where Comment_replyOf_Message.ParentMessageId=aggView4777630678631792815.v1;
create or replace view aggView5885175817910675318 as select v3, SUM(annot) as annot, v2 from aggJoin4960903443201522322 group by v3,v2;
create or replace view aggJoin5961500801342602701 as select annot from Comment_hasTag_Tag as cht2, aggView5885175817910675318 where cht2.CommentId=aggView5885175817910675318.v3 and v2<TagId;
select SUM(annot) as v9 from aggJoin5961500801342602701;
