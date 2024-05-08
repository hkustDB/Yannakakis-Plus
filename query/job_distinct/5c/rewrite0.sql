create or replace view semiJoinView7126277529059400529 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info AS mi where (info_type_id) in (select (id) from info_type AS it) and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view semiJoinView8353275358983623814 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies') and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view semiJoinView184707533382577663 as select v15, v1, v9 from semiJoinView8353275358983623814 where (v15) in (select (v15) from semiJoinView7126277529059400529);
create or replace view semiJoinView7133328300475853083 as select id as v15, title as v16, production_year as v19 from title AS t where (id) in (select (v15) from semiJoinView184707533382577663) and production_year>1990;
create or replace view tAux99 as select v16 from semiJoinView7133328300475853083;
select distinct v16 from tAux99;
