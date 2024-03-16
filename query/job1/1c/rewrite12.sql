create or replace view aggView6358473084610686642 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin6551116508097687341 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView6358473084610686642 where mc.movie_id=aggView6358473084610686642.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView7902535287577137033 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin6991817974342273699 as select movie_id as v15 from movie_info_idx as mi_idx, aggView7902535287577137033 where mi_idx.info_type_id=aggView7902535287577137033.v3;
create or replace view aggView2996346771582969394 as select v15 from aggJoin6991817974342273699 group by v15;
create or replace view aggJoin3199891257092782546 as select v1, v9, v28 as v28, v29 as v29 from aggJoin6551116508097687341 join aggView2996346771582969394 using(v15);
create or replace view aggView6550733609488108500 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin3199891257092782546 group by v1;
create or replace view aggJoin7852233859084162723 as select kind as v2, v28, v29, v27 from company_type as ct, aggView6550733609488108500 where ct.id=aggView6550733609488108500.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin7852233859084162723;
