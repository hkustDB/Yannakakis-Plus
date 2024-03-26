create or replace view aggView1580349894739149859 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin2807940673128888407 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView1580349894739149859 where mc.movie_id=aggView1580349894739149859.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1372258144329676628 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin1783686265958400959 as select movie_id as v15 from movie_info_idx as mi_idx, aggView1372258144329676628 where mi_idx.info_type_id=aggView1372258144329676628.v3;
create or replace view aggView8100228513798878333 as select v15 from aggJoin1783686265958400959 group by v15;
create or replace view aggJoin6356692319461439969 as select v1, v9, v28 as v28, v29 as v29 from aggJoin2807940673128888407 join aggView8100228513798878333 using(v15);
create or replace view aggView7274344878473856447 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3951600415748996905 as select v9, v28, v29 from aggJoin6356692319461439969 join aggView7274344878473856447 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3951600415748996905;
