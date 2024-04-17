create or replace view aggView449100567781290719 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin324489914945826965 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView449100567781290719 where mi.movie_id=aggView449100567781290719.v15 and info IN ('USA','America');
create or replace view aggView7774818404319661021 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3060134614672489347 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7774818404319661021 where mc.company_type_id=aggView7774818404319661021.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView4950485659904927483 as select v15 from aggJoin3060134614672489347 group by v15;
create or replace view aggJoin4100805395151822132 as select v3, v13, v27 as v27 from aggJoin324489914945826965 join aggView4950485659904927483 using(v15);
create or replace view aggView344288956897221543 as select id as v3 from info_type as it;
create or replace view aggJoin6895276700929679904 as select v27 from aggJoin4100805395151822132 join aggView344288956897221543 using(v3);
select MIN(v27) as v27 from aggJoin6895276700929679904;
