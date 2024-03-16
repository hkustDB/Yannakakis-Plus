create or replace view aggView3646186397398305104 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin930783598206256393 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView3646186397398305104 where mi_idx.movie_id=aggView3646186397398305104.v15;
create or replace view aggView2744323468497704065 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin2517181452159136054 as select v15, v28, v29 from aggJoin930783598206256393 join aggView2744323468497704065 using(v3);
create or replace view aggView1479853877039753057 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin2517181452159136054 group by v15;
create or replace view aggJoin6300947245539326329 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView1479853877039753057 where mc.movie_id=aggView1479853877039753057.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1906761471360058506 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin6300947245539326329 group by v1;
create or replace view aggJoin308263317949734523 as select kind as v2, v28, v29, v27 from company_type as ct, aggView1906761471360058506 where ct.id=aggView1906761471360058506.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin308263317949734523;
