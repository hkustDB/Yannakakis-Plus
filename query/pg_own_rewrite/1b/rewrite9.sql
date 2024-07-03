create or replace view aggView5208207215173473048 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5052921421798630544 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5208207215173473048 where mc.company_type_id=aggView5208207215173473048.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3766714970948661980 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin506488734238259429 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3766714970948661980 where mi_idx.info_type_id=aggView3766714970948661980.v3;
create or replace view aggView760475398702497441 as select v15, MIN(v9) as v27 from aggJoin5052921421798630544 group by v15;
create or replace view aggJoin51957713234398808 as select v15, v27 from aggJoin506488734238259429 join aggView760475398702497441 using(v15);
create or replace view aggView6492988064677607039 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin5375439929777268978 as select v27, v28, v29 from aggJoin51957713234398808 join aggView6492988064677607039 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5375439929777268978;
