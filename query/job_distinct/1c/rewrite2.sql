create or replace view semiJoinView9139229495606793753 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies');
create or replace view semiJoinView1518448460895947643 as select movie_id as v15, info_type_id as v3 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'top 250 rank');
create or replace view mcAux61 as select v15, v9 from semiJoinView9139229495606793753;
create or replace view semiJoinView7889030177646432502 as select id as v15, title as v16, production_year as v19 from title AS t where (id) in (select (v15) from semiJoinView1518448460895947643);
create or replace view tAux92 as select v15, v16, v19 from semiJoinView7889030177646432502;
create or replace view semiJoinView7457255532862984476 as select distinct v15, v9 from mcAux61 where (v15) in (select (v15) from tAux92);
create or replace view semiEnum7844388339877278799 as select v9, v19, v16 from semiJoinView7457255532862984476 join tAux92 using(v15);
select distinct v9, v16, v19 from semiEnum7844388339877278799;
