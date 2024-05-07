create or replace view aggView4228047332737280810 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7307995712414278439 as select movie_id as v15, note as v9 from movie_companies as mc, aggView4228047332737280810 where mc.company_type_id=aggView4228047332737280810.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1456220703965369948 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin8517218523162713676 as select movie_id as v15 from movie_info_idx as mi_idx, aggView1456220703965369948 where mi_idx.info_type_id=aggView1456220703965369948.v3;
create or replace view aggView4664815617226797898 as select v15 from aggJoin8517218523162713676 group by v15;
create or replace view aggJoin5291992703764503338 as select id as v15, title as v16, production_year as v19 from title as t, aggView4664815617226797898 where t.id=aggView4664815617226797898.v15 and production_year>2000;
create or replace view aggView8291460815253380303 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin5291992703764503338 group by v15;
create or replace view aggJoin9170898269184835691 as select v9, v28, v29 from aggJoin7307995712414278439 join aggView8291460815253380303 using(v15);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin9170898269184835691;
