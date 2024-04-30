create or replace view aggView1018402650881139554 as select id as v12, title as v31 from title as t;
create or replace view aggJoin6526793858741791318 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView1018402650881139554 where mc.movie_id=aggView1018402650881139554.v12;
create or replace view aggView7856578496137648091 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin3925584828347776370 as select v12, v31 from aggJoin6526793858741791318 join aggView7856578496137648091 using(v1);
create or replace view aggView2194794745109905720 as select v12, MIN(v31) as v31 from aggJoin3925584828347776370 group by v12;
create or replace view aggJoin290121048333657737 as select keyword_id as v18, v31 from movie_keyword as mk, aggView2194794745109905720 where mk.movie_id=aggView2194794745109905720.v12;
create or replace view aggView183246482136796780 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2679542829067643153 as select v31 from aggJoin290121048333657737 join aggView183246482136796780 using(v18);
select MIN(v31) as v31 from aggJoin2679542829067643153;
