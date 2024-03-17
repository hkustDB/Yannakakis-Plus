create or replace view aggView8364412283299888449 as select id as v12, title as v31 from title as t;
create or replace view aggJoin8143354589145852011 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView8364412283299888449 where mc.movie_id=aggView8364412283299888449.v12;
create or replace view aggView8857520271386692039 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin5615102380836760594 as select v12, v31 from aggJoin8143354589145852011 join aggView8857520271386692039 using(v1);
create or replace view aggView7581689108095936831 as select v12, MIN(v31) as v31 from aggJoin5615102380836760594 group by v12;
create or replace view aggJoin6754336715612615864 as select keyword_id as v18, v31 from movie_keyword as mk, aggView7581689108095936831 where mk.movie_id=aggView7581689108095936831.v12;
create or replace view aggView8713364931679027749 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2692401849621923876 as select v31 from aggJoin6754336715612615864 join aggView8713364931679027749 using(v18);
select MIN(v31) as v31 from aggJoin2692401849621923876;
