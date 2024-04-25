create or replace view semiJoinView5394979559793304722 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info AS mi where (info_type_id) in (select (id) from info_type AS it) and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view semiJoinView2168299435490089268 as select id as v15, title as v16, production_year as v19 from title AS t where (id) in (select (v15) from semiJoinView5394979559793304722) and production_year>1990;
create or replace view semiJoinView6797292476141594284 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies') and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view semiJoinView3173353592591766605 as select v15, v16, v19 from semiJoinView2168299435490089268 where (v15) in (select (v15) from semiJoinView6797292476141594284);
create or replace view tAux59 as select v16 from semiJoinView3173353592591766605;
select distinct v16 from tAux59;
