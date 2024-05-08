create or replace view aggView8082087656965942719 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin4944287058052291169 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView8082087656965942719 where mi_idx.movie_id=aggView8082087656965942719.v15;
create or replace view aggView6279480763250144692 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin401369319567802527 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6279480763250144692 where mc.company_type_id=aggView6279480763250144692.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView5232507353367212056 as select v15, MIN(v9) as v27 from aggJoin401369319567802527 group by v15;
create or replace view aggJoin8327245026856757097 as select v3, v28 as v28, v29 as v29, v27 from aggJoin4944287058052291169 join aggView5232507353367212056 using(v15);
create or replace view aggView6755277701102820024 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin1761995086745655515 as select v28, v29, v27 from aggJoin8327245026856757097 join aggView6755277701102820024 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin1761995086745655515;
