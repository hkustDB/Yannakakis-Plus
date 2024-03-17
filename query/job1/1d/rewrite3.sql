create or replace view aggView168845214165289278 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin7831395727430617710 as select movie_id as v15 from movie_info_idx as mi_idx, aggView168845214165289278 where mi_idx.info_type_id=aggView168845214165289278.v3;
create or replace view aggView6492531949850013558 as select v15 from aggJoin7831395727430617710 group by v15;
create or replace view aggJoin636055947545075078 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView6492531949850013558 where mc.movie_id=aggView6492531949850013558.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView613041038362979091 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3203145243298971472 as select v15, v9 from aggJoin636055947545075078 join aggView613041038362979091 using(v1);
create or replace view aggView5332321619080148637 as select v15, MIN(v9) as v27 from aggJoin3203145243298971472 group by v15;
create or replace view aggJoin4892398723532919473 as select title as v16, production_year as v19, v27 from title as t, aggView5332321619080148637 where t.id=aggView5332321619080148637.v15 and production_year>2000;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin4892398723532919473;
