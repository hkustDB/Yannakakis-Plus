create or replace view aggView2425724809989421521 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin1441007407742302903 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView2425724809989421521 where mi_idx.movie_id=aggView2425724809989421521.v15;
create or replace view aggView1237567980775064294 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin594978583273139352 as select v15, v28, v29 from aggJoin1441007407742302903 join aggView1237567980775064294 using(v3);
create or replace view aggView2417515448164294892 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin594978583273139352 group by v15;
create or replace view aggJoin5352883713343185709 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView2417515448164294892 where mc.movie_id=aggView2417515448164294892.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView2091821291819714781 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin233783003774634588 as select v9, v28, v29 from aggJoin5352883713343185709 join aggView2091821291819714781 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin233783003774634588;
