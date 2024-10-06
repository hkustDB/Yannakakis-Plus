create or replace view semiUp4411853643166124384 as select CommentId as v3, ParentMessageId as v1 from Comment_replyOf_Message AS Comment_replyOf_Message where (CommentId) in (select (CommentId) from Comment_hasTag_Tag AS cht);
create or replace view semiUp3261761066071226774 as select MessageId as v1, TagId as M_TagId, from Message_hasTag_Tag AS Message_hasTag_Tag where (MessageId) in (select (v1) from semiUp4411853643166124384);
create or replace view semiDown4589646339162717735 as select v3, v1 from semiUp4411853643166124384 where (v1) in (select (v1) from semiUp3261761066071226774);
create or replace view semiDown1750318047339924193 as select CommentId as v3, TagId as cht_TagId from Comment_hasTag_Tag AS cht where (CommentId) in (select (v3) from semiDown4589646339162717735);
create or replace view aggView6232339003562034977 as select v3, cht_TagId, COUNT(*) as annot from semiDown1750318047339924193 group by v3, cht_TagId;
create or replace view aggJoin8113337931834088208 as select v1, annot, cht_TagId from semiDown4589646339162717735 join aggView6232339003562034977 using(v3);
create or replace view aggView6323258738161555075 as select v1, cht_TagId, SUM(annot) as annot from aggJoin8113337931834088208 group by v1, cht_TagId;
create or replace view aggJoin5062140384914213065 as select annot from semiUp3261761066071226774 join aggView6323258738161555075 using(v1) where M_TagId < cht_TagId;
select SUM(annot) as v7 from aggJoin5062140384914213065;
