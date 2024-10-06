create or replace view aggView6456676164022986528 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin6264521124756959741 as select movie_id as v12 from movie_companies as mc, aggView6456676164022986528 where mc.company_id=aggView6456676164022986528.v1;
create or replace view aggView1456994271206158569 as select id as v12, title as v31 from title as t;
create or replace view aggJoin6127091671982701728 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView1456994271206158569 where mk.movie_id=aggView1456994271206158569.v12;
create or replace view aggView5954648246155381982 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2327237719475934705 as select v12, v31 from aggJoin6127091671982701728 join aggView5954648246155381982 using(v18);
create or replace view aggView4502628049873606143 as select v12 from aggJoin6264521124756959741 group by v12;
create or replace view aggJoin4033656898910348851 as select v31 as v31 from aggJoin2327237719475934705 join aggView4502628049873606143 using(v12);
select MIN(v31) as v31 from aggJoin4033656898910348851;
