create or replace view aggView8592230013961697247 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin350825268965667724 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView8592230013961697247 where mc.movie_id=aggView8592230013961697247.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView2514466532911044193 as select id as v3 from info_type as it;
create or replace view aggJoin8145766409933637076 as select movie_id as v15, info as v13 from movie_info as mi, aggView2514466532911044193 where mi.info_type_id=aggView2514466532911044193.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView6423701314864356516 as select v15 from aggJoin8145766409933637076 group by v15;
create or replace view aggJoin7212250575498522315 as select v1, v9, v27 as v27 from aggJoin350825268965667724 join aggView6423701314864356516 using(v15);
create or replace view aggView5575167510129272541 as select v1, MIN(v27) as v27 from aggJoin7212250575498522315 group by v1;
create or replace view aggJoin3869227273588547694 as select kind as v2, v27 from company_type as ct, aggView5575167510129272541 where ct.id=aggView5575167510129272541.v1 and kind= 'production companies';
select MIN(v27) as v27 from aggJoin3869227273588547694;
