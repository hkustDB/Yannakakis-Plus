create or replace view aggView8889388373951265710 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin4648816751858547222 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView8889388373951265710 where mc.movie_id=aggView8889388373951265710.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView2310185276397678027 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin1383749008476732238 as select movie_id as v15 from movie_info_idx as mi_idx, aggView2310185276397678027 where mi_idx.info_type_id=aggView2310185276397678027.v3;
create or replace view aggView2421772804352378929 as select v15 from aggJoin1383749008476732238 group by v15;
create or replace view aggJoin5270173364286639953 as select v1, v9, v28 as v28, v29 as v29 from aggJoin4648816751858547222 join aggView2421772804352378929 using(v15);
create or replace view aggView3752924288590917679 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2489128659726757180 as select v9, v28, v29 from aggJoin5270173364286639953 join aggView3752924288590917679 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2489128659726757180;
