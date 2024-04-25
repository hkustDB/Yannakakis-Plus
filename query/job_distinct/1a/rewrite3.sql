create or replace view semiJoinView4941758977872483556 as select movie_id as v15, info_type_id as v3 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'top 250 rank');
create or replace view semiJoinView4393699933033524990 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies') and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view mcAux25 as select v15, v9 from semiJoinView4393699933033524990;
create or replace view semiJoinView3676531083381194205 as select id as v15, title as v16, production_year as v19 from title AS t where (id) in (select (v15) from semiJoinView4941758977872483556);
create or replace view tAux92 as select v15, v16, v19 from semiJoinView3676531083381194205;
create or replace view semiJoinView4547202815287441883 as select distinct v15, v9 from mcAux25 where (v15) in (select (v15) from tAux92);
create or replace view semiEnum4484535442525997602 as select v9, v16, v19 from semiJoinView4547202815287441883 join tAux92 using(v15);
select distinct v9, v16, v19 from semiEnum4484535442525997602;
