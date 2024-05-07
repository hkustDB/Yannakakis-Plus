create or replace view aggView4404848487340596741 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3820210657452992870 as select movie_id as v15, note as v9 from movie_companies as mc, aggView4404848487340596741 where mc.company_type_id=aggView4404848487340596741.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView4183322447415246489 as select v15 from aggJoin3820210657452992870 group by v15;
create or replace view aggJoin9091802242920514872 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info as mi, aggView4183322447415246489 where mi.movie_id=aggView4183322447415246489.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView7446584486193810638 as select id as v3 from info_type as it;
create or replace view aggJoin6690154629874445995 as select v15, v13 from aggJoin9091802242920514872 join aggView7446584486193810638 using(v3);
create or replace view aggView1741509453869083612 as select v15 from aggJoin6690154629874445995 group by v15;
create or replace view aggJoin2527797289555003887 as select title as v16 from title as t, aggView1741509453869083612 where t.id=aggView1741509453869083612.v15 and production_year>2005;
select MIN(v16) as v27 from aggJoin2527797289555003887;
