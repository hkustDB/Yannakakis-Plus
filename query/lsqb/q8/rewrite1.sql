create or replace view aggView1382430111387842011 as select TagId as v2, COUNT(*) as annot from Comment_hasTag_Tag as cht1 group by TagId;
create or replace view aggJoin5524434800338708842 as select MessageId as v1, TagId as v2, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView1382430111387842011 where Message_hasTag_Tag.TagId=aggView1382430111387842011.v2;
create or replace view aggView7194200444474493083 as select v1, SUM(annot) as annot, v2 from aggJoin5524434800338708842 group by v1,v2;
create or replace view aggJoin4865275707811417718 as select CommentId as v3, v2, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7194200444474493083 where Comment_replyOf_Message.ParentMessageId=aggView7194200444474493083.v1;
create or replace view aggView4336202709400861281 as select v3, SUM(annot) as annot, v2 from aggJoin4865275707811417718 group by v3,v2;
create or replace view aggJoin5807012057366596042 as select TagId as v8, v2, annot from Comment_hasTag_Tag as cht2, aggView4336202709400861281 where cht2.CommentId=aggView4336202709400861281.v3 and v2<TagId;
select SUM(annot) as v9 from aggJoin5807012057366596042;
