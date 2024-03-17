create or replace view aggView5487246956594771609 as select id as v12, title as v31 from title as t;
create or replace view aggJoin8558314920158631523 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView5487246956594771609 where mc.movie_id=aggView5487246956594771609.v12;
create or replace view aggView2624277038175871676 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin8859928134990016608 as select v12, v31 from aggJoin8558314920158631523 join aggView2624277038175871676 using(v1);
create or replace view aggView1017351422274353572 as select v12, MIN(v31) as v31 from aggJoin8859928134990016608 group by v12;
create or replace view aggJoin7620799231772672677 as select keyword_id as v18, v31 from movie_keyword as mk, aggView1017351422274353572 where mk.movie_id=aggView1017351422274353572.v12;
create or replace view aggView5951128772023851511 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8291999620200864336 as select v31 from aggJoin7620799231772672677 join aggView5951128772023851511 using(v18);
select MIN(v31) as v31 from aggJoin8291999620200864336;
