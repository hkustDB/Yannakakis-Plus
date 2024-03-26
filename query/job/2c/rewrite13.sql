create or replace view aggView1048449110545942820 as select id as v12, title as v31 from title as t;
create or replace view aggJoin1582641355338879581 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView1048449110545942820 where mk.movie_id=aggView1048449110545942820.v12;
create or replace view aggView3295819262985576459 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin4144960324463831953 as select movie_id as v12 from movie_companies as mc, aggView3295819262985576459 where mc.company_id=aggView3295819262985576459.v1;
create or replace view aggView7224279607554797699 as select v12 from aggJoin4144960324463831953 group by v12;
create or replace view aggJoin8665374430843350671 as select v18, v31 as v31 from aggJoin1582641355338879581 join aggView7224279607554797699 using(v12);
create or replace view aggView2293725637237038257 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin468999071953067120 as select v31 from aggJoin8665374430843350671 join aggView2293725637237038257 using(v18);
select MIN(v31) as v31 from aggJoin468999071953067120;
