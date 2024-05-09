create or replace view aggView2268917615021438562 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin314645226898472085 as select movie_id as v12 from movie_companies as mc, aggView2268917615021438562 where mc.company_id=aggView2268917615021438562.v1;
create or replace view aggView2885709591666763896 as select v12, COUNT(*) as annot from aggJoin314645226898472085 group by v12;
create or replace view aggJoin4896924161630260900 as select id as v12, annot from title as t, aggView2885709591666763896 where t.id=aggView2885709591666763896.v12;
create or replace view aggView7345191699213501708 as select v12, SUM(annot) as annot from aggJoin4896924161630260900 group by v12;
create or replace view aggJoin3683685632664440302 as select keyword_id as v18, annot from movie_keyword as mk, aggView7345191699213501708 where mk.movie_id=aggView7345191699213501708.v12;
create or replace view aggView328903725625638503 as select v18, SUM(annot) as annot from aggJoin3683685632664440302 group by v18;
create or replace view aggJoin2625783619633830941 as select keyword as v9, annot from keyword as k, aggView328903725625638503 where k.id=aggView328903725625638503.v18 and keyword= 'character-name-in-title';
select SUM(annot) as v31 from aggJoin2625783619633830941;
