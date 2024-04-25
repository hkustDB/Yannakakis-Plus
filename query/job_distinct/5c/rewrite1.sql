create or replace view semiJoinView8182485172243416317 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies') and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view semiJoinView104202352452176394 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info AS mi where (movie_id) in (select (v15) from semiJoinView8182485172243416317) and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view semiJoinView6534385931601802787 as select v15, v3, v13 from semiJoinView104202352452176394 where (v3) in (select (id) from info_type AS it);
create or replace view semiJoinView4679801349521846576 as select id as v15, title as v16, production_year as v19 from title AS t where (id) in (select (v15) from semiJoinView6534385931601802787) and production_year>1990;
create or replace view tAux59 as select v16 from semiJoinView4679801349521846576;
select distinct v16 from tAux59;
