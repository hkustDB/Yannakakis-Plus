create or replace view aggView6112304434513642510 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin2269278836234091250 as select movie_id as v15 from movie_info_idx as mi_idx, aggView6112304434513642510 where mi_idx.info_type_id=aggView6112304434513642510.v3;
create or replace view aggView63669382375126786 as select v15 from aggJoin2269278836234091250 group by v15;
create or replace view aggJoin7246885417708942244 as select id as v15, title as v16, production_year as v19 from title as t, aggView63669382375126786 where t.id=aggView63669382375126786.v15 and production_year>2010;
create or replace view aggView478104085596750922 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin7246885417708942244 group by v15;
create or replace view aggJoin4784483150900697247 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView478104085596750922 where mc.movie_id=aggView478104085596750922.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView194876072500787651 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4783549536427321187 as select v9, v28, v29 from aggJoin4784483150900697247 join aggView194876072500787651 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4783549536427321187;
